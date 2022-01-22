import { Component, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { Car } from 'src/app/models/car.model';

@Component({
  selector: 'app-car-element',
  templateUrl: './car-element.component.html',
  styleUrls: ['./car-element.component.css']
})
export class CarElementComponent implements OnInit {
  @Input() car: Car;
  @Input() currency: string;
  @Input() fxRate: number;

  constructor() { }

  ngOnInit(): void {
  }

  onSelectCar() {
    console.log(this.car.brand.name + ' ' + this.car.model)
  }

  calculateUsdPrice(price: number): number {
    return Number(price) * Number(this.fxRate)
  }
}
