<template>
<div @click="() => {this.$store.commit('toggleSideBar')}" class="wrapper">
    <!-- on click update the view sidebar value -->
    <div class="hamburgerMenu">
        <div class="bar"></div>
        <div class="bar"></div>
        <div class="bar"></div>
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
    }
}
</script>

<style scoped>

.wrapper {
    position: absolute;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 3em;
    height: 3em;

    margin: 1em;
    border-radius: 1em;
    z-index: 3;
    /* background: #fff; */
}
.hamburgerMenu {

    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
    height: 2em;
    
}
.bar {

width: 2em;
height: 0px;
border: 0.15em solid #fff;
border-radius: 1em;

}

</style>