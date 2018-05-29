<template>
  <div class="container">
    <p>Welcome to {{ appName }}!</p>
    <div id="messages" class="container">
    </div>
    <div id="footer" class="row">
      <div class="col-sm-2">
        <div class="input-group">
          <span class="input-group-addon">@</span>
          <input id="username" type="text" class="form-control" placeholder="username">
        </div><!-- /input-group -->
      </div><!-- /.col-lg-6 -->
      <div class="col-sm-10">
        <input id="message-input" class="form-control" />
      </div><!-- /.col-lg-6 -->
    </div><!-- /.row -->
  </div>
</template>

<style lang="stylus" scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

<script lang="ts">
import Vue from 'vue'
import { Component, Emit, Inject, Model, Prop, Provide, Watch } from 'vue-property-decorator'
import $ from 'jquery'
import { Socket } from "phoenix"

@Component({ name: 'App' })
export default class App extends Vue {
  appName: string = 'websocket-chat';

  static init(){
    let socket = new Socket("/socket", {
      logger: ((kind: number, msg: string, data: any) => { console.log(`${kind}: ${msg}`, data) })
    })

    socket.connect({user_id: "123"})
    var $status    = $("#status")
    var $messages  = $("#messages")
    var $input     = $("#message-input")
    var $username  = $("#username")

    socket.onOpen( (ev: any)  => console.log("OPEN", ev) )
    socket.onError( (ev: any) => console.log("ERROR", ev) )
    socket.onClose( (e: any) => console.log("CLOSE", e))

    var chan = socket.channel("rooms:lobby", {})
    chan.join().receive("ignore", () => console.log("auth error"))
               .receive("ok", () => console.log("join ok"))
               .receive("timeout", () => console.log("Connection interruption"))
    chan.onError((e: any) => console.log("something went wrong", e))
    chan.onClose((e: any) => console.log("channel closed", e))

    $input.off("keypress").on("keypress", e => {
      if (e.keyCode == 13) {
        chan.push("new:msg", {user: $username.val(), body: $input.val()})
        $input.val("")
      }
    })

    chan.on("new:msg", msg => {
      if (msg.user !== 'SYSTEM' || msg.body !== 'ping') {
        $messages.append(this.messageTemplate(msg))
        scrollTo(0, document.body.scrollHeight)
      }
    })

    chan.on("user:entered", msg => {
      var username = this.sanitize(msg.user || "anonymous")
      $messages.append(`<br/><i>[${username} entered]</i>`)
    })
  }

  static sanitize(html: string){ return $("<div/>").text(html).html() }

  static messageTemplate(msg: any){
    let username = this.sanitize(msg.user || "anonymous")
    let body     = this.sanitize(msg.body)

    return(`<p><a href='#'>[${username}]</a>&nbsp; ${body}</p>`)
  }
}

$( () => App.init() )
</script>
