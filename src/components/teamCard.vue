<template>
<div class="teamCard">
    <div class="bar"></div>
    <div class="title"><span style="color:#F37520">{{ team.substring(0, 1) }}</span><span>{{ team.substring(1) }}</span>
    <img src="" alt=""></div>
    <img :src="`/${team}.jpg`" alt="">
    
    <p style="text-align: justify;" v-html="desc">
    </p>
    <ul>
        <li v-for="(link, social) in links"><a target="_blank" :href="link"><img style="border: none; margin: 0;" :src="'/' + social + 'iconwhite.png'" alt="" height="32" width="32"></a></li>
    </ul>
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
        },
        links: {
            type : Object,
            
        }
    },
    mounted () {
        return
    }
}
</script>

<style scoped>

ul {
    display: flex;
    list-style: none;
    height: 32px;
    width: 50%;
    padding: 0;
    margin-bottom: -1em;
    margin-top: 1em;
    position: relative;
}
li {
    margin-right: 1.5em;
    list-style: none;
    display: inline-block;
}

span {
    position: relative;
    font-size: 4em;
    font-weight: bold;
    letter-spacing: 0.1em;
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


</style>