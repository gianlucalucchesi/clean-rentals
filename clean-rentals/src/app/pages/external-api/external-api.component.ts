import { Component } from '@angular/core';
import { AuthClientConfig } from '@auth0/auth0-angular';
import { ApiService } from 'src/app/services/api.service';

@Component({
  selector: 'app-external-api',
  templateUrl: './external-api.component.html'
})
export class ExternalApiComponent {
  responseJson: string;
  audience = this.configFactory.get()?.audience;
  hasApiError = false;

  constructor(
    private api: ApiService,
    private configFactory: AuthClientConfig
  ) {}

  pingApi() {
    this.responseJson = null;

    this.api.ping$().subscribe({
      next: (res) => {
        this.hasApiError = false;
        this.responseJson = JSON.stringify(res, null, 2).trim();
      },
      error: () => this.hasApiError = true,
    });
  }

  pingSecureApi() {
    this.responseJson = null;

    this.api.pingSecureApi$().subscribe({
      next: (res) => {
        this.hasApiError = false;
        this.responseJson = JSON.stringify(res, null, 2).trim();
      },
      error: () => this.hasApiError = true,
    });
  }

}
