<template>
    <div class="landingPage">
        <div class="bar"></div>
        <p id="title">Are You Ready For Euphorux 2023?</p>
        <div class="time">
                <p>{{ days }} </p>
                <p>:</p>
                <p>{{ hours }} </p>
                <p>:</p>
                <p>{{ minutes }}</p>
                <p>:</p>
                <p>{{ seconds }}</p>
        </div>

        <div class="named">
            <p id="days">DAYS</p>
            <p id="hrs">HOURS</p>
            <p id="mins">MINUTES</p>
            <p id="secs">SECONDS</p>
        </div>

        <div class="upcoming"><span>TILL </span><span class="upcoming">{{ this.$store.state.upcomingRun }} </span></div>

        <div class="bar"></div>

        <button @click="() => {console.log(this.$store.state.showSideBar)}" class="cta"><p id="ctatext">READY TO EXPLORE</p><p id="subtext">sign in with Google</p></button>

        <div class="bar"></div>
        <p>Check Out Our Past Years</p>
    </div>
</template>

<script>

//import

export default {
    name: "landingPage",
    components: {
        
    },
    data () {
        return {days : "",
                hours : "",
                minutes : "",
                seconds : ""}
    },
    mounted () {
        const till = new Date(this.$store.state.upcomingRun)
        const now = new Date();
        const msleft = till - now;
        const left = new Date(msleft);

        // ALL THIS TO PRELOAD FIRST
        this.days = String(Math.floor(msleft / (1000 * 3600 * 24))).padStart(2, '0');
        this.hours = String(left.getHours()).padStart(2, '0');
        this.minutes = String(left.getMinutes()).padStart(2, '0');
        this.seconds = String(left.getSeconds()).padStart(2, '0');

        return 
    },
    created() {
        setInterval(() => {this.countdown();}, 1000)
    },
    methods: {
        countdown() {
            if (this.seconds > 0) {
                this.seconds = String(this.seconds - 1).padStart(2, '0');
            } else if (this.minutes > 0) {
                this.seconds = '59';
                this.minutes = String(this.minutes - 1).padStart(2, '0');
            } else if (this.hours > 0) {
                this.seconds = '59';
                this.minutes = '59';
                this.hours = String(this.hours - 1).padStart(2, '0');
            }
        },
    },
    watch: {
        // $route (to, from) {
        //     this.$store.commit('toggleSideBar');
        // }
    }
}
</script>

<style scoped>

* {
    margin: 0 auto;
    font-family: Zuuma;
    font-weight: bold;
}

span {
    font-size: 3em;
    color: #fff;
}

p {
    font-size: 3em;
    margin: 0 auto;
}

.bar {

    width: 80%;
    height: 0px;

    margin: 2em auto;
    border: 0.15em solid #454545;
    border-radius: 1em;

}

#title {
    margin: 0.5em auto;
}

.named {

    display: flex;

    width: 90%;
    height: auto;

    margin: 0 auto;
    padding: 0;
    justify-content: space-between;
    font-size: 0.4em;
}

.named p {
    position: relative;
}

#days {
    left: 0.2em
}

#hrs {
    left: 0.7em
}

#mins {
    left: 0.7em
}

#secs {
    left: 0.3em
}

.upcoming {
    margin-top: 2em;
    color: #F37520;
}

.cta {
    width: 201px;
    height: 60px;

    background: #F37520;
    border: 2px solid #454545;
}

#ctatext {
    font-family: 'Secular One';
    font-size: 1.6em;
    line-height: 29px;

    color: #fff;
    text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.3);

}

#subtext {
    font-family: 'Secular One';
    font-size: 0.8em;

    color: #fff;

    text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.3);
}

.time {
    width: 80%;
    height: auto;

    display: flex;

} 

.time p {
    width: 1em;
}

</style>