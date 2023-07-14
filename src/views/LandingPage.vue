<template>
    <div class="landingPage">
        <img id="logo" src="../../public/euphoruxlogo.png" alt="">
        <p id="title">Are You Ready For<br>Euphorux 2023?</p>
        <div v-if="!ongoing">
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
        </div>

        <div v-else style="font-size: 3em;">
            ! IT'S HAPPENING NOW !
        </div>

        <div class="bar"></div>

        <button @click="redirect" class="cta"><p id="ctatext">READY TO EXPLORE?</p><span class="subtext">sign up here!</span></button>
        <div style="font-family: 'Secular One'; font-size: 0.8em; margin-top: 1em; margin-bottom: -1em; width: fit-content;" @click="trylogin">or login here</div>
        <!-- <div class="subtext" style="font-size: 1em; margin-top: 0.5em; text-decoration: underline; font-style: italic; color: #ccc;">Already signed up?</div> -->

        <div class="bar"></div>
        <gallery/>
    </div>
</template>

<script>

import gallery from '@/components/gallery.vue'

export default {
    name: "landingPage",
    components: {
        gallery
    },
    data () {
        return {days : "",
                hours : "",
                minutes : "",
                seconds : "",
                ongoing : false,
            }
    },
    async mounted () {
        window.scrollTo(0, 0)

        const till = new Date(this.$store.state.upcomingRun)
        const now = new Date();
        const msleft = till - now - 1000 * 3600 * 8;
        const left = new Date(msleft);

        if(msleft <= 0) {
            this.ongoing = true;
            return
        }

        // ALL THIS TO PRELOAD FIRST
        this.days = String(Math.floor(msleft / (1000 * 3600 * 24))).padStart(2, '0');
        this.hours = String(left.getHours()).padStart(2, '0');
        this.minutes = String(left.getMinutes()).padStart(2, '0');
        this.seconds = String(left.getSeconds()).padStart(2, '0');
        setInterval(() => {this.countdown();}, 1000)
        if (!this.$store.state.clansteams) {
            this.$store.commit('getClansTeams');
        }
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
        async redirect() {
            if (await this.$store.getters.hasValidToken) {
                    this.$router.push('/yourteam')
                } else {
                window.open('https://docs.google.com/forms/d/e/1FAIpQLSfzycWtZzE7TA2Jm8vA5d6rNuqWdzThf-HkUgZt1aBW-Cqzug/viewform')
            }
        },
        async trylogin() {
            if (await this.$store.getters.hasValidToken) {
                this.$router.push('/yourteam')
            } else {
                this.$store.state.showLogin = true
            }
        }
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
    font-size: 4em;
    margin: 0.5em auto;
    z-index: 1;
}

.landingPage {
    position: relative;
    z-index: 0;
    height: 100%;
}

#logo {
    display: block;
    max-width: 140%;
    position: absolute;
    top: -4em;
    left: -9999px;
    right: -9999px;
    margin: auto;
    opacity: 0.2;
    z-index: -1;
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
    display: block;
    width: 60%;
    height: 70px;

    background: #F37520;
    border: 2px solid #454545;
}

#ctatext {
    font-family: 'Secular One';
    font-size: 1.6em;
    line-height: 29px;

    color: #fff;
    text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.15);

}

.subtext {
    font-family: 'Secular One';
    font-size: 1.2em;

    color: #fff;

    text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.15);
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