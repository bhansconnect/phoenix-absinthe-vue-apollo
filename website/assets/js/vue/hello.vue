<template>
  <div>
    <input type="text" v-model="name" placeholder="Your name"/>
    <a href="#" @click.prevent="doSay">Say my name</a>
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: ""
    };
  },
  methods: {
    doSay() {
      var name = this.name;
      alert(name);
    }
  }
};
</script>
