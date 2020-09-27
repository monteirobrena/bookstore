import EmberRouter from '@ember/routing/router';
import config from 'bookstore/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function() {
  // this.route('books');
  this.route('books', { path : '/' });
  this.route('author', { path: '/authors/:author_id' });
});
