import { Component, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Reservation } from 'src/app/models/reservation.model';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-reservation-element',
  templateUrl: './reservation-element.component.html',
  styleUrls: ['./reservation-element.component.css'],
})
export class ReservationElementComponent {
  @Input() reservation: Reservation;

  constructor(
    private reservationService: ReservationService,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  onSelectReservation() {
    this.reservationService.setCurrentReservationId(this.reservation.id);
    this.router.navigate([this.reservation.id], { relativeTo: this.route });
  }
}
