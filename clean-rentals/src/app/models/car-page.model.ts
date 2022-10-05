import { Car } from './car.model';

export class CarPage {
  content: Car[];
  pageable: {
    sort: {
      sorted: boolean;
      unsorted: boolean;
    };
    offset: number;
    pageNumber: number;
    pageSize: number;
    paged: boolean;
    unpaged: boolean;
  };
  totalPages: number;
  last: false;
  totalElements: number;
  size: number;
  number: number;
  numberOfElements: number;
  sort: {
    sorted: boolean;
    unsorted: boolean;
  };
  first: boolean;
}
