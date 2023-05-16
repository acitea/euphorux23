<script setup>
import headerMain from "./components/Header.vue";
import sideBar from "./components/sideBar.vue";
</script>

<template>
<!-- <nav>
  <router-link to="/">Home</router-link> |
  <router-link to="/about">About</router-link>
  <template>
  </nav> -->
  <div class="mainBack">
    <headerMain/>
    <router-view/>
    <sideBar v-if="this.$store.state.showSideBar"/>
  </div>
</template>


<style>

* {
  margin: 0;
  padding: 0;
}

@import url('https://fonts.googleapis.com/css2?family=Secular+One&display=swap');

@font-face {
  font-family: "Zuuma";
  font-weight: 400;
  src: local("Zuuma"), url("assets/fonts/Zuuma/ZuumeRough-Regular.ttf") format("truetype");
}

@font-face {
  font-family: "Zuuma";
  font-weight: bold;
  src: local("Zuuma"), url("assets/fonts/Zuuma/ZuumeRough-Bold.ttf") format("truetype");
}

#app {
  font-family: Zuuma, Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #fff;
}

.mainBack {
  outline: red dashed 1px;
}

</style>
