<template>
<div class="theTeams">
    <h1 class="title">THE TEAMS</h1>
    <div class="bar"></div>
    <p>Introducing the <span style="color: #F37520; font-weight: bold; font-size: 1.3em;">6</span> teams, the core of SMUXploration Crew <br><br>
    You will be trying out what they have to offer and get to know them better. Seek the adventure, Explore the horizons</p>
    <teamCard v-for="(desc, team) in teams" :team="team" :desc="desc"/>
</div>
</template>

<script>

import teamCard from '@/components/teamCard.vue';

export default {
    name: "theTeams",
    components: {
        teamCard
    },
    data () {
        return {
            teams : {'diving' : 'Live, breathe, beneath with SMUX Diving Team. <br><br> As the only scuba diving team in SMU, we provide a platform for students to interact, share knowledge, and pursue their passion for the ocean and its marine inhabitants. <br><br>Our aim is to introduce diving to the uninitiated, sharing the beauty of the underwater and to spread conservation initiatives to the masses through dive events and marine conservation projects.',
                    'skate' : `We are an inline skating team in SMU that is open to all students. Whether you’re a pro or have never picked up a pair of skates before, we welcome everyone to the SMUX Skating family! <br><br>
                                Our weekly Friday sessions have a training segment where we teach beginners how to skate from scratch and give intermediates a space to have some fun and learn new tricks. After training, we bring skaters who are urban-proficient to skate in the city for dinner before skating back to school. Our urban locations vary from week to week, bringing you to signature food spots in Singapore nearby school!`,
                    'trek' : `Got an Attitude for Altitude? <br><br>
                                The SMUX Trekking Team was started as a platform for members passionate about trekking to prepare and build camaraderie for treks together.  <br><br>
                                Join us on our Wednesday runs or Saturday hikes, to meet new people and get your weekly dose of exercise! We also organise exciting events during the midterm, winter and summer breaks that will bring you and your friends to interesting places around Singapore! Look out for our upcoming orienteering sessions, campfires and even an overseas expedition!`,
                    'biking' : 'We seek to cater to riders of all proficiency levels. <br><br>By riding to various places in Singapore, we mingle over food, share new experiences with one another and make new friends! Students who join us are casual riders and students who just want to explore our little island together. We are very welcoming, so fret not! <br><br> You provide the legs, we provide the ride and great experience. ',
                    'xseed' : `XSEED is an outdoor adventure sports club providing students with a platform to venture into thrilling board-sports such as Cable Skiing, Longboarding, and Stand-Up Paddleboarding. <br><br>
                                Over the years, we have built a community of outgoing and adventurous individuals who eagerly take part in our regular activities. In addition to our line-up of local regular activities, XSEED also organises overseas expeditions for SMU students to cultivate adventurousness and global exposure. Students will have opportunities to organise and try out new adventure sports which are unavailable in Singapore such as Alpine Sports, ATV Cross Country Riding & White Water Rafting. <br><br>
                                You can expect to grow holistically within a community of like minded-individuals and hone your sporting skills with our activities! Join us as we Xplore frontiers and share Xciting adventures together!`,
                    'kayak' : `We are a family of new and seasoned kayakers who are always looking forward to our next adventure together. <br><br>
                                As a team, we embark on weekly adventures around Marina Reservoir, Pasir Ris, Sembawang and many more locations! Our club also seeks to take on expeditions beyond Singapore’s shores. We’ve kayaked in the calm rivers in Perth, scenic waters of Lake Toba and Taiwan as well as white water rafting together with our fellow SMUX Xseed friends!`,
                }
        }
    },
}
</script>

<style scoped>

p {
    font-family: 'Secular One';
    font-size: 1em;
    text-align: left;
    width: 80%;
    margin: 0 auto;
}

.title {
    position: relative;
    width: auto;
    top: 0.5em;

    font-weight: bold;
    font-size: 4em;
    letter-spacing: 0.1em;
}

.bar {

width: 80%;
height: 0px;

margin: 2em auto;
border: 0.15em solid #454545;
border-radius: 1em;

}
</style>