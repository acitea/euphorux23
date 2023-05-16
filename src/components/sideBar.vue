<template>
<div class="sidebar">
    <p id="back">ARROW BACK</p>
    <div class="bar"></div>
    <div class="navLinks">
        <router-link to="/" class="links">HOME</router-link>
        <router-link to="/" class="links">THE STORY</router-link>
        <router-link to="/theteams" class="links">THE TEAMS</router-link>
        <router-link to="/" class="links">OUR SOCIALS</router-link>
        <router-link to="/" class="links">JOIN SMU-X!</router-link>
        <router-link to="/scoreboard" class="links">SCOREBOARD</router-link>
        <router-link to="/" class="links">YOUR TEAM</router-link>
    </div>
</div>
</template>

<script>

//import

export default {
    name: "sidebar",
    components: {
        
    },
    mounted () {
        return
    }
}
</script>

<style scoped>

* {
    font-family: "Secular One";
    font-size: 1.5em;
    color: #fff;
    text-decoration: none;
}

.bar {

width: 55vw;
height: 0px;
border: 0.06em solid #fff;
border-radius: 1em;

margin: 1em auto;
}
.sidebar {
    /* Rectangle 7 */

position: fixed;
top: 0;
width: 66vw;
height: 100vh;

background: #454545cc;
backdrop-filter: blur(4px);

border-right: 0.25em solid #333;

}

#back {
    position: relative;
    width: 100%;
    margin: 0.5em auto;

}

.navLinks {
    width: 50vw;
    height: 45vh;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: start;
}

.links {
    font-size: 0.7em;
    background-image: linear-gradient(#F37520 0 0);
    background-repeat: no-repeat;
    background-size: 0% 0.15em;
    background-position: bottom left;

    transition: background-size 0.2s, translate 0.4s;

} 

.links:hover {
    translate: 0.5em 0em;
    background-size: 80% 0.15em;
}

</style>