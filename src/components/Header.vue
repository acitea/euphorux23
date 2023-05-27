<template>
    <hamburgerMenu id="menu"/>
    <div class="headerMain"><img id="logo" src="../assets/SMUXLogoWHITE.png" width="246" alt=""></div>
    <div class="bar"></div>
</template>

<script>

import hamburgerMenu from './hamburgerMenu.vue';

export default {
    name: "headerMain",
    components: {
        hamburgerMenu
    },
    mounted () {
        return
    }
}
</script>

<style scoped>
* {
    background: #151515;
}

#logo {
    margin: 2em auto;
    margin-bottom: 0;
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