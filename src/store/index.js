import { createStore } from 'vuex'
import axios from 'axios'

export default createStore({
  state () {
    return {
      showSideBar : false,
      role: null,
      yourteam: null,
      yourclan: null,
      showLogin : false,
      upcomingRun: '4 July 2023',
      navLinks: {'HOME' : '/',
      'THE STORY' : '/story',
      'THE TEAMS' : '/teams',
      'OUR SOCIALS' : '/socials',
      'JOIN SMU-X!' : '/',
      'SCOREBOARD' : '/scoreboard',
      'YOUR TEAM' : '/yourteam'},
      clansteams: null,
    }
  },
  getters: {
  },
  mutations: {
    toggleSideBar(state) {
      state.showSideBar = !state.showSideBar;
    },

    async getClansTeams(state) {
      state.clansteams = {};
      // TODO: IF A PAGE IS LOADED THAT REQUIRES DATA, LOAD IT IN AND STORE IT FOR FUTURE USE. TEMPORILY
      const resClans = await axios.get(process.env.VUE_APP_API_NAME+"/clans", {
        withCredentials: true, 
      });
              resClans.data.forEach(element => {
                  state.clansteams[element.clanName] = [];
              });
              
      console.log('calling for');
      const resTeams = await axios.get(process.env.VUE_APP_API_NAME+"/teams", {
        withCredentials: true, 
      });
      resTeams.data.forEach(element => {
        state.clansteams[element.clanName].push(element.teamName)
      })
      
      console.log(state.clansteams);
    },

    setUserInfo(state, userinfo) {
      state.role = userinfo.role;
      state.yourteam = userinfo.teamName;
      state.yourclan = userinfo.clanName;
    }
  },
  actions: {
    

  },
  modules: {
  }
})
