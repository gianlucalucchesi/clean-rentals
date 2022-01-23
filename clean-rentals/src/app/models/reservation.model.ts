import { Car } from "./car.model";
import { Client } from "./client.model";
import { Location } from "./location.model"
import { ReservationOption } from "./reservation-option.model";

export class Reservation {
  id: string;
  client: Client;
  car: Car;
  location: Location;
  reservationOptions?: ReservationOption[];
  dateTimeStart: Date;
  dateTimeStop?: Date;
  total_price_euro_excl_vat: number;
}
