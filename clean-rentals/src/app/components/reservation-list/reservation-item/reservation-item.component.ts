import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';
import { Reservation } from 'src/app/models/reservation.model';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-reservation-item',
  templateUrl: './reservation-item.component.html',
  styleUrls: ['./reservation-item.component.css'],
})
export class ReservationItemComponent implements OnInit, OnDestroy {
  reservationId: string;
  currentReservationId$: Subscription;
  reservation: Reservation;

  constructor(
    private reservationService: ReservationService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    // https://angular-training-guide.rangle.io/routing/child_routes
    this.currentReservationId$ = this.route.params.subscribe((params) => {
      this.reservationId = params['id'];
      this.getReservation();
    });
  }

  ngOnDestroy(): void {
    this.currentReservationId$.unsubscribe();
    this.reservationService.setCurrentReservationId(null);
  }

  getReservation() {
    this.reservationService
      .getReservationItem$(this.reservationId)
      .subscribe((reservation) => (this.reservation = reservation));
  }
}
