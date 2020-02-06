import _ from 'lodash';


export class InitialReducer {
    reduce(json, state) {
        let data = _.get(json, 'initial', false);
        if (data) {
          console.log('initialR', json)
          state.con = data.con
          state.hon = data.hon
        }
    }
}
