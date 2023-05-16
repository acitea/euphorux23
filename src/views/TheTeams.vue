<template>
<div class="theTeams">
    I AM TEAMS
</div>
</template>

<script>

//import

export default {
    name: "theTeams",
    components: {
        
    },
    mounted () {
        console.log('ROUTE CHANGED');
        setTimeout(() => {this.$store.commit('toggleSideBar')}, 300);
        return
    },
    watch: {
        $route (to, from) {
            //BUG: I CANT GET THIS TO WORK SOMEHOW
        }
    }
}
</script>

<style scoped>

</style>