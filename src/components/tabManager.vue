<template>
    <div class="tabManager">
        
        <div class="tabHeader">
            <div class="tabs" @click="selectedTab = 'game'; $emit('selectedTab', 'game')" :style="selectedTab != 'game' ? {'filter' : 'brightness(0.5)', 'flex' : '2', 'font-size' : '1em'} : {}">
                <p>GAMES</p>
                <div class="bottom" :class="{'selectedTab' : selectedTab == 'game'}"></div>
            </div>
            <div class="tabs" @click="selectedTab = 'power'; $emit('selectedTab', 'power')" :style="selectedTab != 'power' ? {'filter' : 'brightness(0.5)', 'flex' : '2', 'font-size' : '1em'} : {}">
                <p>POWERS</p>
                <div class="bottom" :class="{'selectedTab' : selectedTab == 'power'}"></div>
            </div>
            <!-- <div class="tabs" @click="selectedTab = 'THIRD'" :style="selectedTab != 'THIRD' ? {'filter' : 'brightness(0.5)', 'flex' : '1', 'font-size' : '1em'} : {}">
                <p>THIRD</p>
                <div class="bottom" :class="{'selectedTab' : selectedTab == 'THIRD'}"></div>
            </div> -->
        </div>
        
    </div>
</template>

<script>

    export default {
        name: 'tabManager',
        components: {
            
        },
        data() {
            return {
                selectedTab : 'game',
            }
        },
    }
  </script>

<style scoped>

* {
    margin: 0 auto;
    padding: 0;
}

.tabManager {
    width: 80%;
    margin: 0.5em 0;
}

    .tabHeader {
        display: flex;
        flex-direction: row;
        font-family: 'Secular One';
    }

    .tabs {
        flex: 3;
        font-size: 1.3em;
        height: 4vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        transition: all 0.3s ease-in-out;
    }

    .bottom {
        position: relative;
        height: 0;
        bottom: -0.15em;
        width: 50%;
        border-bottom: 0.15em solid grey;
        transition: all 0.2s ease-in-out;
        
    }

    .selectedTab {
        width: 80%;
        border-bottom: 0.15em solid #F37520;
        /* box-shadow: 0px 0.2em 0.5em white; */
    }
</style>