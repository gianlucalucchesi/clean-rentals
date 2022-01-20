import { Component, OnInit, Output, ViewChild } from '@angular/core';
import { AuthService, User } from '@auth0/auth0-angular';
import { take } from 'rxjs';
import { Client } from 'src/app/models/client.model';
import { ClientService } from 'src/app/services/client.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
})
export class ProfileComponent implements OnInit {
  @Output() client: Client;

  constructor(public auth: AuthService, private clientService: ClientService) {}

  ngOnInit(): void {
    this.auth.user$.pipe(take(1)).subscribe((profile) => {
      this.clientService
        .getClientByAuth0Id$(profile.sub)
        .pipe(take(1))
        .subscribe((client) => {
          next: this.client = client;
        });
    });
  }
}
