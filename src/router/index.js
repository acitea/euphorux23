import { createRouter, createWebHashHistory } from 'vue-router'
import LandingPage from '../views/LandingPage.vue'
import GameMaster from '../views/GameMaster.vue'
import ScoreBoard from '../views/ScoreBoard.vue'
import TheTeams from '../views/TheTeams.vue'


const routes = [
  {
    path: '/',
    name: 'landingPage',
    component: LandingPage,
  },
  {
    path: '/gamemaster',
    name: 'gameMaster',
    component: GameMaster
  },
  {
    path: '/scoreboard',
    name: 'ScoreBoard',
    component: ScoreBoard
  },
  {
    path: '/theteams',
    name: 'TheTeams',
    component: TheTeams
  },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
