import { Component, Input } from '@angular/core';
import { Car } from 'src/app/models/car.model';

@Component({
  selector: 'app-car-element',
  templateUrl: './car-element.component.html',
  styleUrls: ['./car-element.component.css'],
})
export class CarElementComponent {
  @Input() car: Car;
  @Input() currency: string;
  @Input() fxRate: number;

  constructor() {}

  calculateUsdPrice(price: number): number {
    return Number(price) * Number(this.fxRate);
  }
}
