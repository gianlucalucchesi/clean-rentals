import { Component, Input } from '@angular/core';
import { Car } from 'src/app/models/car.model';
import { CurrencyService } from 'src/app/services/currency.service';

@Component({
  selector: 'app-car-element',
  templateUrl: './car-element.component.html',
  styleUrls: ['./car-element.component.css'],
})
export class CarElementComponent {
  @Input() car: Car;
  @Input() currency: string;

  constructor(private currencyService: CurrencyService) {}

  getUsdPrice(): number {
    return this.currencyService.convertEuroToUsd(
      this.car.start_day_price_euro_excl_vat
    );
  }
}
