import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-reservation-item',
  templateUrl: './reservation-item.component.html',
  styleUrls: ['./reservation-item.component.css'],
})
export class ReservationItemComponent implements OnInit, OnDestroy {
  reservationId: string;
  currentReservationId$: Subscription;

  constructor(
    private reservationService: ReservationService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    this.currentReservationId$ = this.route.params.subscribe(params => {
      this.reservationId = params['id'];
      console.log('Opened reservation ' + this.reservationId)
    })
  }

  ngOnDestroy(): void {
    this.currentReservationId$.unsubscribe();
    this.reservationService.setCurrentReservationId(null);
  }
}
