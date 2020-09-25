import Publisher from './publisher';
import { on } from '@ember/object/evented';

export default Publisher.extend({
  onDidLoad: on('didLoad', function() {
    this.set('loadedAt', new Date());
  })
});
