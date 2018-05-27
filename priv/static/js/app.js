// for phoenix_html support, including form and button helpers
// copy the following scripts into your javascript bundle:
// * https://raw.githubusercontent.com/phoenixframework/phoenix_html/v2.10.0/priv/static/phoenix_html.js

let socket = new Phoenix.Socket("/socket", {
    params: {token: window.userToken},
    logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data); }
});
