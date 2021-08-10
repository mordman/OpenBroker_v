import React, { Component } from 'react';

export class FetchData extends Component {
  static displayName = FetchData.name;

  constructor(props) {
    super(props);

      /*
      this.From = Date.now();
      this.To = Date.now();
      this.OutType = "XLSx";
      */
      this.state = { GetData: [], loading: true, From: "2019-01-01", To: "2022-01-01", OutType:"JSON" };
    }

    
    

    componentDidMount() {
        this.populateGetData();
    }

    handleChangeOutType(event) {
        this.setState({ OutType: event.target.value });
    }

    handleChangeFrom(event) {
        this.setState({ From: event.target.value });
    }

    handleChangeTo(event) {
        this.setState({ To: event.target.value });
    }


    static renderGetDataTable(GetData) {
    return (
      <table className='table table-striped' aria-labelledby="tabelLabel">
        <thead>
          <tr>
                    <th>Наименование книги</th>
                    <th>Авторы</th>
                    <th>Всего экземпляров(шт.)</th>
                    <th>Выдано за период(шт.)</th>
                    <th>Кол-во экземпляров в хранилище(шт.)</th>
          </tr>
        </thead>
        <tbody>
                {GetData.map(item =>
                    <tr key={item.name}>
                        <td>{item.name}</td>
                        <td>{item.authors}</td>
                        <td>{item.count_item}</td>
                        <td>{item.issue}</td>
                        <td>{item.actual}</td>
            </tr>
          )}
        </tbody>
      </table>
    );
  }

  render() {
    let contents = this.state.loading
      ? <p><em>Loading...</em></p>
        : FetchData.renderGetDataTable(this.state.GetData);

    return (
      <div>
            <h1 id="tabelLabel" >Open Broker</h1>
            <p>From: <input type="date" id="from" value={this.state.From} onChange={(e) => this.handleChangeFrom(e)} /></p>
            <p>To: <input type="date" id="to" value={this.state.To} onChange={(e) => this.handleChangeTo(e)} /></p>
                    <p>OutType: 
          <select value={this.state.OutType} onChange={(e) => this.handleChangeOutType(e)} id="OutType">
                        <option value="JSON">JSON</option>
                        <option value="XLSx">XLSx</option>
                        </select></p>
            <input type="Button" value="Done" onClick={() => this.componentDidMount()} />
        {contents}
      </div>
    );
  }

    async populateGetData() {
        const response = await fetch('http://localhost:58010/GetDataInfo/GetJSON?from=' + this.state.From + '&to=' + this.state.To);
        //alert('http://localhost:58010/GetDataInfo/GetJSON?from=' + this.state.From + '&to=' + this.state.To);
    const data = await response.json();
        this.setState({ GetData: data, loading: false });

        if (this.state.OutType == "XLSx") {
            window.open('http://localhost:58010/GetDataInfo/GetXLSx?from=' + this.state.From + '&to=' + this.state.To, '_blank', 'noopener,noreferrer')
        }
  }
}
