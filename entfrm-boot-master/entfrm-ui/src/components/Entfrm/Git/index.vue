<template>
  <div>
    <svg-icon icon-class="github" @click="goto"/>
  </div>
</template>

<script>
export default {
  name: 'EntfrmGit',
  data() {
    return {
      url: 'https://gitee.com/entfrm/entfrm-boot'
    }
  },
  methods: {
    goto() {
      window.open(this.url)
    }
  }
}
</script>
