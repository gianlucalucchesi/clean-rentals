import { Brand } from "./brand.model";
import { CarOption } from "./car-option.model";

export class Car {
  id: string;
  brand: Brand;
  model: string;
  image_url: string;
  carOptions?: CarOption;
  start_day_price_euro_excl_vat: number;
  seats: number;
  doors: number;
}
