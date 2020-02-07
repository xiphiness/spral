import React, { Component } from 'react';
import _ from 'lodash';
import classnames from 'classnames';
import { store } from '/store';



export class FileSystem extends Component {

    constructor(props) {
    super(props);
    this.state = store.state;
    store.setStateHandler(this.setState.bind(this));
    // store.setStateHandler(this.setState.bind(this));
  }

    render() {
      let deskKeys = this.props.pathname
                   .split('/')
                   .slice(2);
      if(deskKeys[0] == '') {
        deskKeys = deskKeys.slice(1)
      }
      const loc = deskKeys[0] === '' ||  deskKeys.length < 1 ?  'dir' :
                    'dir.'.concat(deskKeys
                   .join('.dir.').concat('.dir'));
      const dirObj = _.get(this.state.hon, loc, false);
      return _.keys(dirObj).map((key, i) => (
          <p key={i} className="lh-copy measure pt3">Directory: {key}</p>
      ));
    }
}

export default FileSystem
