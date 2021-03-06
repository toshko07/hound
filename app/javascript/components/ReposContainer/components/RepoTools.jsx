import React from 'react';

import RepoToolsSearch from './RepoTools/RepoToolsSearch';
import RepoToolsRefresh from './RepoTools/RepoToolsRefresh';
import RepoToolsPrivate from './RepoTools/RepoToolsPrivate';

export default class RepoTools extends React.Component {
  render() {
    const {
      onSearchInput,
      showPrivateButton,
      isSyncing,
      onRefreshClicked,
    } = this.props;

    return (
      <div className="repo-tools">
        {showPrivateButton && <RepoToolsPrivate />}
        <RepoToolsRefresh
          isSyncing={isSyncing}
          onRefreshClicked={onRefreshClicked}
        />
        <RepoToolsSearch onSearchInput={onSearchInput} />
      </div>
    );
  }
}
