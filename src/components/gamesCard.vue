<template>
<div class="gamesCard">
    <div class="gameName">
        {{ name }}
    </div>
    <div class="points">
        {{ table.points }} &hairsp; pts
    </div>
</div>
</template>

<script>

//import

export default {
    name: "gamesCard",
    components: {
        
    },
    props: {
        name: String,
        table: Object
    },
    mounted () {
        return
    }
}
</script>

<style scoped>

.gamesCard {
    font-size: 0.8em;
    position: relative;
    width: 100%;
    height: 6vh;
    outline: 2px solid white;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    z-index: 0;
}

.gameName {
    flex: 3;
    border-right: 2px solid white;
}

.points {
    flex: 2;
    border-left: 2px solid white;
}

</style>