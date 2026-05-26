 (function(factory) {
   typeof define === "function" && define.amd ? define(factory) : factory();
 })(function() {
   "use strict";
   const getOffset = (el) => {
     const box = el.getBoundingClientRect();
     return [
       box.top + window.pageYOffset - document.documentElement.clientTop,
       box.left + window.pageXOffset - document.documentElement.clientLeft
     ];
   };
   const getNodePosition = (node) => {
     if (!node || node.tagName.toLowerCase() === "body") {
       return [0, 0];
     }
     var _node = node;
     const [top = 0, left = 0] = getOffset(_node);
     if (!top && !left) {
       return getNodePosition(_node.offsetParent);
     } else {
       _node = null;
       return [top, left];
     }
   };
   const isTkignore = (ele) => {
     const tkignore = ele.getAttribute("tkignore");
     return !!(tkignore && tkignore.toString() === "true");
   };
   const isTkStayEndFn = (ele) => {
     const tkStayEnd = ele.getAttribute("tk-stay-end");
     return !!(tkStayEnd && tkStayEnd.toString() === "true");
   };
   const getUrlParam = () => {
     let href = window.location.href;
     href = href.split("?")[1];
     const param = {};
     if (href) {
       href.split("&").map((item) => {
         const [key, value] = item.split("=");
         param[key] = value;
       });
     }
     return param;
   };
   const getNodeName = (node) => {
     return node.nodeName.toLocaleLowerCase();
   };
   const getFillUrl = (url) => {
     if (url) {
       const aEle = document.createElement("a");
       aEle.href = url;
       return aEle.href;
     } else {
       return "";
     }
   };
   const getAudioSrc = (audioTarget) => {
     if (audioTarget.src || audioTarget.currentSrc) {
       return audioTarget.src || audioTarget.currentSrc;
     }
     var audioFileUrl = void 0;
     var audioOggUrl = void 0;
     var audioSrc = void 0;
     audioSrc = audioTarget.getAttribute ? audioTarget.getAttribute("src") : audioTarget.src;
     if (audioSrc && audioSrc !== "about:blank") {
       audioFileUrl = audioSrc;
       audioOggUrl = audioSrc;
     }
     return getFillUrl(audioFileUrl || audioOggUrl);
   };
   const getVideoSrc = (videoTarget) => {
     if (!videoTarget.querySelectorAll) {
       return videoTarget.src;
     }
     var videoFileUrl = void 0;
     var videoOggUrl = void 0;
     var videoSrc = void 0;
     videoSrc = videoTarget.getAttribute ? videoTarget.getAttribute("src") : videoTarget.src;
     videoSrc = videoSrc || videoTarget.currentSrc;
     if (videoSrc && videoSrc !== "about:blank") {
       videoFileUrl = videoSrc;
       videoOggUrl = videoSrc;
     }
     return getFillUrl(videoFileUrl || videoOggUrl);
   };
   function _postMessageToParent1(data) {
     if (window.parent && window.parent !== window) {
       try {
         var source = "tk_h5Document";
         var sendData = null;
         if (data.audioElementId) {
           sendData = {
             source,
             data,
             method: "clinetAudioPlayer"
           };
         } else {
           sendData = {
             source,
             data,
             method: "clinetVideoPlayer"
           };
         }
         sendData = JSON.stringify(sendData);
         console.log("iframe to parent postMessage:", sendData);
         console.error("h5Document iframe to parent postMessage: ", JSON.parse(sendData));
         window.parent.postMessage(sendData, "*");
       } catch (e2) {
         console.error("that.postMessageToParent error:", e2);
       }
     }
   }
   var timeout;
   window.addEventListener("message", function(e) {
     var data = JSON.parse(e.data);
     if (data.method == "onJumpPage") {
       if (timeout) {
         clearTimeout(timeout);
       }
     }
   }, false);
   const throttle = (func, delay, executeLastTime) => {
     let startTime = Date.now();
     return function() {
       const context = this;
       let currentTime = Date.now();
       const args = Array.prototype.slice.apply(arguments);
       clearTimeout(timeout);
       if (currentTime - startTime >= delay) {
         func.apply(context, args);
         startTime = currentTime;
       } else {
         timeout = setTimeout(() => {
           func.apply(context, args);
           clearTimeout(timeout);
           timeout = null;
         }, delay);
       }
     };
   };
   const _postMessageToParent = throttle(_postMessageToParent1, 500);
   var callback = function(mutations) {
     mutations.forEach(function(mutation) {
       console.error(mutation);
       if (mutation.type === "attributes") {
         if (mutation.attributeName === "src") {
           console.error("切换src了，\n这是老的：", mutation.target.currentSrc);
           if (mutation.target.tagName.toLocaleLowerCase() === "video") {
             VideoAction.vidoeClose({ src: mutation.target.currentSrc });
           }
           if (mutation.target.tagName.toLocaleLowerCase() === "audio") {
             AudioAction.audioClose({ src: mutation.target.currentSrc });
           }
           mutation = null;
         }
       }
     });
   };
   var observer = new MutationObserver(callback);
   const observerMediaSrc = (ele) => {
     observer.observe(ele, {
       attributes: true,
       attributeFilter: ["src"]
     });
   };
   class VideoAction {
     // 重新定义video的play方法
     static redefineVideoPlay(target) {
       var ele = target ? target : this;
       if (isTkignore(ele)) {
         return ele._play();
       }
       const isTkStayEnd = isTkStayEndFn(ele);
       ele.playsInline = true;
       ele.setAttribute("playsinline", "true");
       ele.setAttribute("webkit-playsinline", "true");
       ele.addEventListener("DOMNodeRemoved", function(mutations) {
         if (mutations.target.src) {
           VideoAction.vidoeClose(mutations.target, true);
           mutations = null;
         }
       });
       observerMediaSrc(ele);
       var videoSrc = getVideoSrc(ele);
       if (videoSrc) {
         console.info("Play videoSrc:", videoSrc);
         if (!ele.id) {
           ele.id = "playCustomVideo_" + (/* @__PURE__ */ new Date()).getTime();
         }
         const [top, left] = getNodePosition(ele);
         let width = ele.offsetWidth;
         let height = ele.offsetHeight;
         if (ele.getBoundingClientRect) {
           const temp = ele.getBoundingClientRect();
           width = temp.width;
           height = temp.height;
         }
         var position = {
           height,
           width,
           top,
           left
         };
         var data = {
           videoElementId: ele.id,
           isPlay: true,
           status: "play",
           fileid: window.GLOBAL && window.GLOBAL.fileid,
           url: videoSrc,
           isTkStayEnd,
           currentTime: ele.currentTime || 0,
           duration: ele.duration || 0,
           position
         };
         _postMessageToParent(data);
       } else {
         return;
       }
       if (typeof ele.setVolume === "function") {
         ele.setVolume(0);
       }
       if (ele._element && ele._element._gainObj && ele._element._gainObj.gain && ele._element._gainObj.gain.setValueAtTime) {
         ele._element._gainObj.gain.setValueAtTime(0, ele._element.currentTime);
         ele._element._gainObj.gain.linearRampToValueAtTime(0, ele._element.currentTime + 0.01);
         ele._element._gainObj.gain.exponentialRampToValueAtTime(0, ele._element.currentTime + 0.01);
       }
       ele.muted = true;
       ele.volume = 0;
       if (ele && ele._play && typeof ele._play === "function") {
         return ele._play.apply(ele, arguments);
       }
     }
     // 重新定义video的pause方法
     static redefineVideoPause(target) {
       var ele = target ? target : this;
       if (isTkignore(ele)) {
         if (ele && ele._pause && typeof ele._pause === "function") {
           return ele._pause.apply(ele, arguments);
         }
         return;
       }
       var videoSrc = getVideoSrc(ele);
       if (videoSrc) {
         if (!ele.id) {
           ele.id = "pauseCustomVideo_" + (/* @__PURE__ */ new Date()).getTime();
         }
         const [top, left] = getNodePosition(ele);
         let width = ele.offsetWidth;
         let height = ele.offsetHeight;
         if (ele.getBoundingClientRect) {
           const temp = ele.getBoundingClientRect();
           width = temp.width;
           height = temp.height;
         }
         var position = {
           height,
           width,
           top,
           left
         };
         var data = {
           videoElementId: ele.id,
           isPlay: false,
           status: "pause",
           fileid: window.GLOBAL && window.GLOBAL.fileid,
           url: videoSrc,
           currentTime: ele.currentTime || 0,
           duration: ele.duration || 0,
           position
         };
         _postMessageToParent(data);
       }
       if (ele && ele._pause && typeof ele._pause === "function") {
         return ele._pause.apply(ele, arguments);
       }
     }
     // 定义关闭方法
     static vidoeClose(ele) {
       var videoSrc = getVideoSrc(ele);
       if (!videoSrc) return;
       ele = null;
       var data = {
         status: "close",
         fileid: window.GLOBAL && window.GLOBAL.fileid,
         url: videoSrc
       };
       _postMessageToParent(data);
     }
   }
   class AudioAction {
     /*重新定义audio的play方法*/
     static redefineAudioPlay(target) {
       var ele = target ? target : this;
       if (isTkignore(ele)) {
         return ele._play();
       }
       ele.addEventListener("DOMNodeRemoved", function(mutations) {
         if (mutations.target.src) {
           AudioAction.audioClose(mutations.target);
           mutations = null;
         }
       });
       observerMediaSrc(ele);
       ele.style.display = "none";
       var audioSrc = getAudioSrc(ele);
       if (audioSrc) {
         if (!ele.id) {
           ele.id = "playCustomAudio_" + (/* @__PURE__ */ new Date()).getTime();
         }
         var data = {
           audioElementId: ele.id,
           status: "play",
           isPlay: true,
           fileid: window.GLOBAL && window.GLOBAL.fileid,
           url: audioSrc,
           currentTime: ele.currentTime || 0,
           duration: ele.duration || 0
         };
         _postMessageToParent(data);
       }
       if (typeof ele.setVolume === "function") {
         theleis.setVolume(0);
       }
       if (ele._element && ele._element._gainObj && ele._element._gainObj.gain && ele._element._gainObj.gain.setValueAtTime) {
         ele._element._gainObj.gain.setValueAtTime(0, ele._element.currentTime);
         ele._element._gainObj.gain.linearRampToValueAtTime(0, ele._element.currentTime + 0.01);
         ele._element._gainObj.gain.exponentialRampToValueAtTime(0, ele._element.currentTime + 0.01);
       }
       ele.muted = true;
       ele.volume = 0;
       if (ele && ele._play && typeof ele._play === "function") {
         return ele._play.apply(ele, arguments);
       }
     }
     /*重新定义audio的pause方法*/
     static redefineAudioPause(target) {
       var ele = target ? target : this;
       if (isTkignore(ele)) {
         return ele._pause();
       }
       var audioSrc = getAudioSrc(ele);
       if (audioSrc) {
         if (!ele.id) {
           ele.id = "pauseCustomAudio_" + (/* @__PURE__ */ new Date()).getTime();
         }
         var data = {
           audioElementId: ele.id,
           status: "pause",
           isPlay: false,
           fileid: window.GLOBAL && window.GLOBAL.fileid,
           url: audioSrc,
           currentTime: ele.currentTime || 0,
           duration: ele.duration || 0
         };
         _postMessageToParent(data);
       }
       if (ele && ele._pause && typeof ele._pause === "function") {
         return ele._pause.apply(ele, arguments);
       }
     }
     static audioClose(ele) {
       var audioSrc = getAudioSrc(ele);
       if (!audioSrc) return;
       ele = null;
       var data = {
         status: "close",
         fileid: window.GLOBAL && window.GLOBAL.fileid,
         url: audioSrc
       };
       _postMessageToParent(data);
     }
   }
   const version = "2.0.1";
   const updateTime = "2025/7/24 10:39:23";
   console.log("h5课件外放插件当前版本: ", version, "日期: ", updateTime);
   function main() {
     let { isH5MediaOutput } = getUrlParam();
//       web打包时要注释掉这段
//     if (!isH5MediaOutput || isH5MediaOutput.toString() !== "true") return;
     _audioInit();
     _videoInit();
     var audioList = document.querySelectorAll("audio");
     var videoList = document.querySelectorAll("video");
     _registerMediaEle([...audioList, ...videoList]);
     var config = {
       childList: true,
       subtree: true
     };
     function findMedia(dom) {
       if (dom.nodeName.toLocaleLowerCase() === "audio") {
         return !dom.isIncluded && audioList.push(dom);
       } else if (dom.nodeName.toLocaleLowerCase() === "video") {
         return !dom.isIncluded && videoList.push(dom);
       }
       var children = dom.children;
       if (children && children.length) {
         for (var node of children) {
           findMedia(node);
         }
       }
     }
     var body = document.querySelector("body");
     var observer2 = new MutationObserver(callback2);
     observer2.observe(body, config);
     function callback2(mutationsList) {
       audioList = [];
       videoList = [];
       mutationsList.forEach((element) => {
         if (element.addedNodes.length) {
           element.addedNodes.forEach(function(ele) {
             if (ele.innerHTML) {
               if (ele.innerHTML.indexOf("video") !== -1 || ele.innerHTML.indexOf("audio") !== -1) {
                 findMedia(ele);
               }
             }
           });
         }
       });
       if (audioList.length || videoList.length) {
         _registerMediaEle([...audioList, ...videoList]);
       }
     }
     function _videoInit() {
       if (window.GLOBAL && window.GLOBAL.isCocosFile) {
         window.cc.Video.prototype._play = window.cc.Video.prototype.play;
         window.cc.Video.prototype._pause = window.cc.Video.prototype.pause;
         window.cc.Video.prototype.play = VideoAction.redefineVideoPlay;
         window.cc.Video.prototype.pause = VideoAction.redefineVideoPause;
       }
       window.HTMLVideoElement.prototype._play = window.HTMLVideoElement.prototype.play;
       window.HTMLVideoElement.prototype._pause = window.HTMLVideoElement.prototype.pause;
       window.HTMLVideoElement.prototype.play = VideoAction.redefineVideoPlay;
       window.HTMLVideoElement.prototype.pause = VideoAction.redefineVideoPause;
     }
     function _audioInit() {
       if (window.GLOBAL && window.GLOBAL.isCocosFile) {
         window.cc.Audio.prototype._play = window.cc.Audio.prototype.play;
         window.cc.Audio.prototype._pause = window.cc.Audio.prototype.pause;
         window.cc.Audio.prototype.play = AudioAction.redefineAudioPlay;
         window.cc.Audio.prototype.pause = AudioAction.redefineAudioPause;
       }
       window.HTMLAudioElement.prototype._play = window.HTMLAudioElement.prototype.play;
       window.HTMLAudioElement.prototype._pause = window.HTMLAudioElement.prototype.pause;
       window.HTMLAudioElement.prototype.play = AudioAction.redefineAudioPlay;
       window.HTMLAudioElement.prototype.pause = AudioAction.redefineAudioPause;
     }
     function _registerMediaEle(nodeList) {
       nodeList.forEach((node) => {
         node.isIncluded = true;
         node.volume = 0;
         if (isTkignore(node)) {
           return;
         }
         if (node.autoplay) {
           getNodeName(node) === "audio" && AudioAction.redefineAudioPlay(node);
           getNodeName(node) === "video" && VideoAction.redefineVideoPlay(node);
         } else {
           node.addEventListener("play", function() {
             getNodeName(node) === "audio" && AudioAction.redefineAudioPlay(node);
             getNodeName(node) === "video" && VideoAction.redefineVideoPlay(node);
           });
         }
       });
     }
   }
   main();
 });

