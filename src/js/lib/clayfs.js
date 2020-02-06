import _ from 'lodash';
import classnames from 'classnames';

export function parseDirectory(dirObj, name) {
  _.transform(dirObj, (acc, v, k) => {
    if(_.has(v, 'dir')) {
      _.keys(v.dir).map((key) => {
        const val = v[key]
        if(_.has(val, 'dir')) acc.dir.push(key)
        if(_.has(val, 'dir')) acc.fil.push([name,key])
      })
    }
  }, {dir: [], fil: []})
}
