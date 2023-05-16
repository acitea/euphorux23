<template>
    <hamburgerMenu id="menu"/>
    <div class="headerMain"><img id="logo" src="../assets/SMUXLogoWHITE.png" width="246" alt=""></div>

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

/* #menu {
    float: left;
    left: 3em;
} */
</style>