import _ from 'lodash';


export class UpdateReducer {
    reduce(json, state) {
        // let data = _.get(json, 'update', false);
        let data = _.get(json, 'update', false);
        if (data) {
          console.log('updateR', json)
            // this.reduceInbox(_.get(data, 'inbox', false), state);
            if(data.con) {
              this.reduceCon(data.con, state)
            }
            if(data.hon) {
              this.reduceHon(data.hon, state)
            }
        }
    }

    reduceCon(con, state) {
      state.con = con
    }

    reduceHon(hon, state) {
      state.hon = hon
    }

    // reduceInbox(inbox, state) {
    //     if (inbox) {
    //         state.inbox = inbox;
    //     }
    // }
}
