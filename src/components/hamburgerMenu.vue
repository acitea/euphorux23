<template>
<div @click="() => {this.$store.commit('toggleSideBar')}" class="wrapper" :style="{position: (this.$store.state.showSideBar) ? 'fixed' : 'absolute'}">
    <!-- on click update the view sidebar value -->
    <div class="hamburgerMenu">
        <div :class="(this.$store.state.showSideBar) ? 'menubar top' : 'menubar'"></div>
        <div class="menubar"></div>
        <div :class="(this.$store.state.showSideBar) ? 'menubar bot' : 'menubar'"></div>
    </div>
</div>
</template>

<script>

export default {
    name: "hamburgerMenu",
    components: {
    },
    mounted () {
        return
    },
}
</script>

<style scoped>

.wrapper {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 3em;
    height: 3em;
    margin: 1em;
    border-radius: 1em;
    background: none;
}
.hamburgerMenu {

    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
    height: 2em;
    
}
.menubar {

width: 2em;
height: 0px;
border: 0.15em solid #fff;
border-radius: 1em;

}

.top {
    position: relative;
    transform: rotate(-45deg);
    left: -0.6em;
    top: 0.2em;
    width: 1em;
}

.bot {
    position: relative;
    transform: rotate(45deg);
    left: -0.6em;
    bottom: 0.2em;
    width: 1em;
}

</style>