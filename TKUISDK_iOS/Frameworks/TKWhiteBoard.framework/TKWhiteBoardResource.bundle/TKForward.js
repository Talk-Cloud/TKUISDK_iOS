window.addEventListener("message", (event) => {
    console.log(event);
    let data = event.data
    try {
        if (typeof data === 'string') {
            data = JSON.parse(data);
        }
    } catch (e) {
        console.log('course json data parse failed, json data: ', data);
    }
    const method = data.method
    if (method === "clinetVideoPlayer" || method === "clinetAudioPlayer") {
        data= data.data;
        data.fileId = data.fileid;
        
        console.log(data);
        if (method === "clinetVideoPlayer") {
            const iframeELe = document.querySelector("#defaultTalkcloudH5Document_h5DocumentIframe")
            data.position.top = data.position.top  + iframeELe.getBoundingClientRect().top
            data.position.left = data.position.left + iframeELe.getBoundingClientRect().left
            window.webkit.messageHandlers.h5PlayVideoInNative.postMessage({data});
        }
        if (method === "clinetAudioPlayer") {
            window.webkit.messageHandlers.h5PlayAudioInNative.postMessage({data});
        }

    }
})
