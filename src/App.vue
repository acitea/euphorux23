<script setup>
import headerMain from "./components/Header.vue";
import sideBar from "./components/sideBar.vue";
import footerMain from "./components/footerMain.vue"
import login from "./components/login.vue";

</script>

<template><div :style="[$route.path == '/' ? {'background' : 'url(\'landing.png\')', 'background-size' : '200px 960px'} : {'background' : 'url(\'bg.png\')', 'background-size' : '540px 960px'}]" id="app">
  
      <headerMain/>
      <login v-if="$store.state.showLogin"/>
      <router-view/>
      <Transition name="sideEnter">
        <sideBar v-if="$store.state.showSideBar"/>
      </Transition>
      <footerMain/>
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
  min-height: 100vh;
  background: #151515;
  height: auto;
}

.sideEnter-enter-from,
.sideEnter-leave-to{
  translate: -66vw
}

.sideEnter-enter-active,
.sideEnter-leave-active {
  transition: translate 0.3s;
}

.bar {

width: 80%;
height: 0px;

margin: 2em auto;
margin-bottom: 1em;
border: 0.15em solid #454545;
border-radius: 1em;
}
</style>
