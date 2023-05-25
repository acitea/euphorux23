<template>
<div class="teamCard">
    <div class="bar"></div>
    <div class="title"><span style="color:#F37520">{{ this.team.substring(0, 1) }}</span><span>{{ this.team.substring(1) }}</span></div>
    <img :src="`/${team}.jpg`" alt="">
    
    <p style="text-align: justify;" v-html="desc">
    </p>
</div>
</template>

<script>


export default {
    name: "teamCard",
    components: {
        
    },
    props: {
        team: String,
        desc: {
            type : String,
            default : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla gravida et est id convallis. In quis semper dui. Nulla magna ex, efficitur nec libero ac, venenatis porta libero. Vivamus rutrum, dolor sed maximus facilisis, nisl lacus iaculis lacus, nec vulputate risus risus eget elit. "
        }
    },
    mounted () {
        return
    }
}
</script>

<style scoped>

span {
    position: relative;
    font-size: 4em;
    font-weight: bold;
    letter-spacing: 0.1em;
    /* float: left; */
}

p {
    font-family: 'Secular One';
    font-size: 1em;
    text-align: left;
}

img {
    display: block;
    max-width: 100%;
    min-height: 40%;
    border: 2px solid #fff;
    margin-top: 1em;
    margin-bottom: 2em;
}
.title {
    display: flex;
    margin: 1em auto;
    margin-bottom: 0.5em;
    align-items: left;
}

.teamCard {
    width: 80vw;
    margin: 0 auto;
}
.bar {

width: 100%;
height: 0px;

margin: 2em auto;
margin-bottom: 1em;
border: 0.15em solid #454545;
border-radius: 1em;

}

</style>