import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';
import { Reservation } from 'src/app/models/reservation.model';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-reservation-detail',
  templateUrl: './reservation-detail.component.html',
  styleUrls: ['./reservation-detail.component.css']
})
export class ReservationDetailComponent implements OnInit, OnDestroy {
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
