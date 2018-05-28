<template>
  <p>{{ greeting }}, world!</p>
</template>

<style lang="stylus" scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  name: 'App',
  data: function() {
    return {
      greeting: 'Hello',
    }
  }
})
</script>
