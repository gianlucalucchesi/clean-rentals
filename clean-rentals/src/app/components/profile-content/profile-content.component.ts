import { Component, Input, OnInit } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { Client } from 'src/app/models/client.model';

@Component({
  selector: 'app-profile-content',
  templateUrl: './profile-content.component.html',
  styleUrls: ['./profile-content.component.css'],
})
export class ProfileContentComponent implements OnInit {
  @Input() client: Client;

  constructor(
    public auth: AuthService) {}

  ngOnInit(): void {}
}
