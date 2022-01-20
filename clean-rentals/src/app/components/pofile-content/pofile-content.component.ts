import { Component, Input, OnInit } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { Client } from 'src/app/models/client.model';

@Component({
  selector: 'app-pofile-content',
  templateUrl: './pofile-content.component.html',
  styleUrls: ['./pofile-content.component.css'],
})
export class PofileContentComponent implements OnInit {
  @Input() client: Client;

  constructor(
    public auth: AuthService) {}

  ngOnInit(): void {}
}
