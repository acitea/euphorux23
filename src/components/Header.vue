<template>
    <hamburgerMenu style="z-index: 2; position: fixed;"/>
    <div class="headerMain" @click="goTop" :style="[$route.path == '/' ? {'background' : 'url(\'landing.png\')', 'background-size' : '200px 960px'} : {'background' : 'url(\'bg.png\')', 'background-size' : '540px 960px'}]">
        <img id="logo" src="../assets/SMUXLogoWHITE.png" width="246" alt="">
        <div id="bar"></div>
    </div>
</template>

<script>

import hamburgerMenu from './hamburgerMenu.vue';

export default {
    name: "headerMain",
    components: {
        hamburgerMenu
    },
    mounted () {
        function scrollFunction() {
        if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
            document.getElementById("logo").style.width = "140px";
            document.getElementById("logo").style.marginTop = "1em";
            document.getElementById("bar").style.marginTop = "0.5em";
            document.getElementById("bar").style.width = "100%";
        } else {
            document.getElementById("logo").style.width = "246px";
            document.getElementById("logo").style.marginTop = "2em";
            document.getElementById("bar").style.marginTop = "2em";
            document.getElementById("bar").style.width = "80%";

        }
        }
        window.onscroll = function() {scrollFunction()};
        return
    },
    methods : {
        goTop() {
            // document.body.scrollTop = 0; // For Safari
            window.scrollTo({top: 0, behavior: 'smooth'})
            // document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera

        }
    }
}
</script>

<style scoped>

* {
    margin: 0;
    padding: 0;
}


#logo {
    margin: 2em auto;
    margin-bottom: 0;
    transition: 0.3s;
}

#bar {
width: 80%;
height: 0px;

margin: 2em auto;
margin-bottom: 1em;
border: 0.15em solid #454545;
border-radius: 1em;
transition: 0.3s;
}

.headerMain {
    margin: 0;
    padding: 0;
    position: sticky;
    position: -webkit-sticky;
    top: 0;
    z-index: 1;
    /* background: none; */

}
</style>