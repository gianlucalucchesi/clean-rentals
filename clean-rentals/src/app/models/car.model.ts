import { Brand } from "./brand.model";
import { CarOption } from "./car-option.model";

export class Car {
  id: string;
  brand: Brand;
  model: string;
  seats: number;
  doors: number;
  year: number;
  horsepower: number;
  wltp_range_km: number;
  battery_capacity_kwh: number;
  start_day_price_euro_excl_vat: number;
  carOptions?: CarOption[];
  image_url: string;
}
