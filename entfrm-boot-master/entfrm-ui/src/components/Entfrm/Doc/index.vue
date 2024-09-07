<template>
  <div>
    <svg-icon icon-class="question" @click="goto"/>
  </div>
</template>

<script>
export default {
  name: 'EntfrmDoc',
  data() {
    return {
      url: 'http://www.entfrm.com/boot'
    }
  },
  methods: {
    goto() {
      window.open(this.url)
    }
  }
}
</script>
