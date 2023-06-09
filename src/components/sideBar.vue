<template>
    <div class="sidebar">
        <p @click="() => {this.$store.commit('toggleSideBar')}" id="back">BACK</p>
        <div class="bar"></div>
        <div class="navLinks">
            <router-link v-for="(link, nav) in navLinks" class="links" @click="() => {this.$store.commit('toggleSideBar')}" :to="link" >{{nav}}</router-link>
            <!-- <router-link @click="() => {this.$store.commit('toggleSideBar')}" to="/" class="links">HOME</router-link> -->
            <!-- <router-link to="/" class="links">THE STORY</router-link> -->
            <!-- <router-link @click="() => {this.$store.commit('toggleSideBar')}" to="/theteams" class="links">THE TEAMS</router-link>
                <router-link @click="() => {this.$store.commit('toggleSideBar')}" to="/yourteam" class="links">YOUR TEAM</router-link>
                <router-link @click="() => {this.$store.commit('toggleSideBar')}" to="/scoreboard" class="links">SCOREBOARD</router-link> -->
                <!-- somehow not working -->
                <!-- <div v-for="(link, nav) in navLinks" class="links">
                    <router-link @click="() => {this.$store.commit('toggleSideBar')}" :to="this.navLinks[link]">{{ link }}</router-link>
                </div> -->
                <a href="https://docs.google.com/forms/d/e/1FAIpQLSdbya6WOiKa22B3OQYv26kYozasVCxbsRNReSyHXI2UFcimiw/viewform" target="_blank" class="links">JOIN SMUX!</a>
            </div>
            
            <router-link @click="() => {this.$store.commit('toggleSideBar')}" to="/gamemaster" class="ops">Game Masters</router-link>
            
            <div @click="$store.state.showSideBar = false" class="back" style="position: fixed; top: 0; left: 67vw; width: 33vw; height: 100vh; background: none;"></div>
    </div>
</template>

<script>

//import

export default {
    name: "sidebar",
    components: {
        
    },
    data () {
        return {navLinks : this.$store.state.navLinks};
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
margin-top: 0.5em;
}
.sidebar {

position: fixed;
top: 0;
width: 66vw;

height: 100vh;

background: #454545cc;
backdrop-filter: blur(4px);

border-right: 0.25em solid #333;
z-index: 1;

}

.ops {
    color: #888;
    /* outline: red dashed 1px; */
    width: 66vw;
    font-size: 0.8em;
    position: absolute;
    left: 0;
    margin: 0 auto;
    bottom: 8vh;
}

#back {
    position: relative;
    width: 100%;
    margin: 0.5em auto;
    left: -0.5em;
    margin-top: 0.4em;
    z-index: 0;
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