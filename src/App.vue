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
    <headerMain/>
    <router-view/>
    <Transition name="sideEnter">
      <sideBar v-if="this.$store.state.showSideBar"/>
    </Transition>
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
  height: 100vh;
  background: #151515
}

.sideEnter-enter-from,
.sideEnter-leave-to{
  translate: -66vw
}

/* .sideEnter-enter-to,
.sideEnter-leave-from{
  translate: 55vw
} */

.sideEnter-enter-active,
.sideEnter-leave-active {
  transition: translate 0.3s;
}

</style>
