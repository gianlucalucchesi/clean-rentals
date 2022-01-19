import { Car } from "./car.model";
import { Client } from "./client.model";
import { Location } from "./location.model"

export class Reservation {
  id: string;
  client: Client;
  car: Car;
  location: Location;
  dateTimeStart: Date;
  dateTimeStop?: Date;
}
