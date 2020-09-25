import Model, { attr, belongsTo } from '@ember-data/model';

export default class BookModel extends Model {
  @attr('string') title;
  @attr('number') price;
  @belongsTo author;
  @belongsTo('publisher', {  inverse: 'books' }) publisher;
}
