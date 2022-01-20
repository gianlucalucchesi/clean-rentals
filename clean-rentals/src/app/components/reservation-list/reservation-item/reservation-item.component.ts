import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { Observable, Subscription } from 'rxjs';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-reservation-item',
  templateUrl: './reservation-item.component.html',
  styleUrls: ['./reservation-item.component.css']
})
export class ReservationItemComponent implements OnInit, OnDestroy {
  reservationId: string;
  currentReservationObservable: Subscription;

  constructor(private reservationService: ReservationService) { }

  ngOnInit(): void {
    this.currentReservationObservable = this.reservationService.currentReservationId$.subscribe((id) => {
      this.reservationId = id;
    })
  }

  ngOnDestroy(): void {
      this.currentReservationObservable.unsubscribe();
      this.reservationService.setCurrentReservationId(null);
  }

}
