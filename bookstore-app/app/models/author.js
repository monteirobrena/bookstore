import Publisher from './publisher';
import { on } from '@ember/object/evented';
import Model, { attr } from '@ember-data/model';

export default Publisher.extend({
  bio: attr('string'),

  onDidLoad: on('didLoad', function() {
    this.set('loadedAt', new Date());
  })
});
