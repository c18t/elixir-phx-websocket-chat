let socket = new Phoenix.Socket("/socket", {
    params: {token: window.userToken},
    logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data); }
});
